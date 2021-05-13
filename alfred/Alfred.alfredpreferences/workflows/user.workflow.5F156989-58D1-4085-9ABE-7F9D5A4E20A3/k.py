import sys
from workflow import Workflow
from icons import SHELL, LOGS, DATADOG, DASHBOARD, KUBE, WATCH, BIN


def main(wf):

    wf.add_item(title="kl",
                subtitle="Access services logs.",
                valid=False,
                autocomplete="l",
                icon=LOGS)
    wf.add_item(title="ks",
                subtitle="Access services shell.",
                valid=False,
                autocomplete="s",
                icon=SHELL)
    wf.add_item(title="kw",
                subtitle="Run service watch",
                valid=False,
                autocomplete="w",
                icon=WATCH)
    wf.add_item(title="kr",
                subtitle="Delete services.",
                valid=False,
                autocomplete="r",
                icon=BIN)
    wf.add_item(title="kd",
                subtitle="Access kubernetes dashboard.",
                valid=False,
                autocomplete="d",
                icon=DASHBOARD)
    wf.add_item(title="kds",
                subtitle="Access kubernetes dashboard - by service",
                valid=False,
                autocomplete="ds",
                icon=DASHBOARD),
    wf.add_item(title="kdm",
                subtitle="Show datadog CPU/Memory metrics for a deployment.",
                valid=False,
                autocomplete="dm",
                icon=DATADOG)
    wf.add_item(title="ksetenv",
                subtitle="Set Workflow variables.",
                valid=False,
                autocomplete="setenv",
                icon=KUBE),
    wf.add_item(title="kclearvars",
                subtitle="Clear all Workflow variables.",
                valid=False,
                autocomplete="clearvars",
                icon=KUBE),



    wf.send_feedback()

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
