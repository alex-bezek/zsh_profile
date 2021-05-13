import sys
from icons import LOGS
from common import get_services, process_and_feedback
from workflow import Workflow

CACHE_MINUTES = 60


def main(wf):
    process_and_feedback(wf, 'kube_services', get_services, LOGS)

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
