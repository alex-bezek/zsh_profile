import sys
from icons import WATCH
from workflow import Workflow
from common import process_and_feedback, get_services


def main(wf):
    process_and_feedback(wf, 'kube_services', get_services, WATCH, include_type_in_arg=True)

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
