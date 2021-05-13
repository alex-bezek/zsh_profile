import sys
from icons import SHELL
from workflow import Workflow
from common import process_and_feedback, get_pods


def main(wf):
    process_and_feedback(wf, 'kube_pods', get_pods, SHELL)

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
