import os
import argparse
import subprocess
from workflow import Workflow


def get_kubectl_cmd_path():
    wf = Workflow()
    return wf.settings.get("KUBECTL_CMD_PATH") or os.environ.get("KUBECTL_CMD_PATH", '/usr/local/bin/kubectl')

class KService:
    def __init__(self, type, name, age, status):
        self.type = type
        self.name = name
        self.age = age
        self.status = status


def get_args(args):
    parser = argparse.ArgumentParser()
    parser.add_argument('query', nargs='?', default="")
    return parser.parse_args(args)


def get_pods():
    res = []

    pods = subprocess.Popen("%s get pods" % get_kubectl_cmd_path(), shell=True, stdout=subprocess.PIPE).stdout.read().split(
        '\n')[
           1:-1]
    for pod_str in pods:
        try:
            dep_name, _, status, _, age = " ".join(pod_str.split()).split(' ')
            res.append(KService("Pod", dep_name, age, status))
        except:
            print("ASd")
    return res


def get_deployments():
    res = []

    deps = subprocess.Popen("%s get deploy" % get_kubectl_cmd_path(), shell=True, stdout=subprocess.PIPE).stdout.read().split(
        '\n')[1:-1]
    for dep_str in deps:
        dep_name, _, current, _, _, age = " ".join(dep_str.split()).split(' ')

        res.append(KService("Deploy", dep_name, age, current))
    return res


def get_replica_sets():
    res = []

    deps = subprocess.Popen("%s get rs" % get_kubectl_cmd_path(), shell=True, stdout=subprocess.PIPE).stdout.read().split(
        '\n')[1:-1]
    for dep_str in deps:
        dep_name, desired, current, _, age = " ".join(dep_str.split()).split(' ')

        res.append(KService("Deploy", dep_name, age, "%s/%s" % (desired, current)))
    return res


def get_services():
    res = []
    res += get_pods()
    res += get_deployments()
    return res


def search_key_for_service(service):
    return u' '.join([
        service.name
    ])


def process_and_feedback(wf, wf_cached_data_key, data_func, icon, include_type_in_arg=False):
    args = get_args(wf.args)
    data = wf.cached_data(wf_cached_data_key, data_func, max_age=60)

    query = args.query.strip()
    if query:
        data = wf.filter(query, data, key=search_key_for_service, min_score=20)

    for d in data:
        if include_type_in_arg:
            arg = "{type} {name}".format(type=d.type.lower(), name=d.name)
        else:
            arg = d.name
        wf.add_item(title=d.name,
                    subtitle="%s - Age: %s | Extra: %s" % (d.type, d.age, d.status),
                    arg=arg,
                    valid=True,
                    icon=icon)

    wf.send_feedback()


def update_local_path_vars(wf):
    set_path_to = os.environ.get('set_path_to')
    configured_path = os.environ.get('configured_path')

    wf.settings[set_path_to] = configured_path
    wf.settings.save()
    print("Successfully set path to %s with %s" % (set_path_to, wf.settings[set_path_to]))


def _report_missing_var(wf, var_name):
    print("Missing dashbaord url; use *ksetenv*")
    """
    wf.add_item(title="Hit enter to set %s environment variable." % var_name,
                arg="setenv",
                valid=True)
    wf.send_feedback()
    """
