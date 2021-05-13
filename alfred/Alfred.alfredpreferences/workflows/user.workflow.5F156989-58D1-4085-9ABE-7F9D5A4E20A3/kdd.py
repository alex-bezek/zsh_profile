import sys
from icons import DASHBOARD
from workflow import Workflow
from common import process_and_feedback, get_services


def main(wf):
    process_and_feedback(wf, 'kube_deploy', get_services, DASHBOARD)

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
