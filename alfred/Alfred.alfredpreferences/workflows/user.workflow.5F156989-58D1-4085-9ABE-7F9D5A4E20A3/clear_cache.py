import sys
from workflow.workflow import Workflow, PasswordNotFound


def main(wf):
	wf.clear_data()
	wf.clear_cache()
	print("Cleared all cached data")

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
