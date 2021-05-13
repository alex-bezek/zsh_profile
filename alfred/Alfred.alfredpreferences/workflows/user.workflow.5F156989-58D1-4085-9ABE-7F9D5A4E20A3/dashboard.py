import sys
import webbrowser
from common import _report_missing_var, get_args

from workflow import Workflow

def _open_url(url):
    if not webbrowser.open(url):
        print("Invalid url; use *ksetenv*")

def main(wf):
    args =  get_args(wf.args)
    query = args.query.strip()

    raw_dashboard_url = wf.settings.get("dashboard_url")
    if not raw_dashboard_url:
        _report_missing_var(wf, "dashboad url")
    else:
        dashboard_url = raw_dashboard_url.strip()
        if query:
            if dashboard_url[-1] == "/":
                base_search = "#!/search?q="
            else:
                base_search = "/#!/search?q="
            _open_url(dashboard_url + base_search + query)
        else:
            _open_url(dashboard_url)


if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
