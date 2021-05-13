import sys
from workflow import Workflow
from icons import SHELL, LOGS, DATADOG, DASHBOARD, WATCH, BIN, KUBE


def main(wf):

    wf.add_item(title="kl",
                subtitle="Access services logs.",
                valid=True,
                arg='kl',
                icon=LOGS)
    wf.add_item(title="ks",
                subtitle="Access services shell.",
                valid=False,
                icon=SHELL)
    wf.add_item(title="kw",
                subtitle="Watch & Describe services in shell.",
                valid=False,
                icon=WATCH)
    wf.add_item(title="kr",
                subtitle="Delete services.",
                valid=False,
                icon=BIN),
    wf.add_item(title="kre",
                subtitle="Delete Evicted Pods.",
                valid=False,
                icon=BIN),
    wf.add_item(title="kd",
                subtitle="Access kubernetes dashboard.",
                valid=False,
                icon=DASHBOARD)
    wf.add_item(title="kds",
                subtitle="Access kubernetes dashboard - by service",
                valid=False,
                icon=DASHBOARD)
    wf.add_item(title="kdm",
                subtitle="Show datadog CPU/Memory metrics for a deployment.",
                valid=False,
                icon=DATADOG),
    wf.add_item(title="ksetenv",
                subtitle="Set Workflow variables.",
                valid=False,
                icon=KUBE),
    wf.add_item(title="kclearvars",
                subtitle="Clear all Workflow variables.",
                valid=False,
                icon=KUBE),


    wf.send_feedback()

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
