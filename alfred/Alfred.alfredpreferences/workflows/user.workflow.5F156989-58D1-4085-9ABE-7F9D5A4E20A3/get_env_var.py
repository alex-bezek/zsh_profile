import sys
from common import *

from workflow import Workflow


def main(wf):
    args = get_args(wf.args)
    query = args.query.strip()
    env_var = wf.settings.get(query) or os.getenv(query)
    if env_var:
        print(env_var)
    else:
        wf.add_item(title="You forget to save your settings, hit return.",
                    arg="setenv",
                    valid=True)
        wf.send_feedback()

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
