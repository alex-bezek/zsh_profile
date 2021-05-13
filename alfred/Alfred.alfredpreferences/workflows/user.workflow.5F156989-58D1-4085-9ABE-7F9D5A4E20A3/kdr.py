import sys
from icons import SHELL
from workflow import Workflow
from common import process_and_feedback, get_replica_sets


def main(wf):
    process_and_feedback(wf, 'kube_replica_sets', get_replica_sets, SHELL)

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
