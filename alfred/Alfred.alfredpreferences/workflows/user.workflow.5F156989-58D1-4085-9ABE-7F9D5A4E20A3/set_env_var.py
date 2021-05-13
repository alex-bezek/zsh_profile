import sys
from common import *

from workflow import Workflow


def main(wf):
    update_local_path_vars(wf)

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
