#!/usr/bin/env python3
"""Gera o diagrama de arquitetura/fluxo da solucao Policy-as-Code.

Fluxo: repositorio CENTRAL de regras (Checkov + cfn-guard) consumido pelos
repositorios de aplicacao via GitHub Actions no Pull Request (gate preventivo).

Uso (venv com 'diagrams' + graphviz):
    python img/architecture.py
Saida: img/architecture.png (e .svg)
"""

from diagrams import Diagram, Cluster, Edge
from diagrams.onprem.vcs import Github
from diagrams.onprem.ci import GithubActions
from diagrams.onprem.iac import Terraform
from diagrams.onprem.client import Users
from diagrams.aws.management import Cloudformation, Config
from diagrams.aws.storage import S3
from diagrams.aws.security import KMS
from diagrams.aws.compute import EC2
from diagrams.aws.database import RDS
from diagrams.programming.flowchart import Decision, StartEnd

graph_attr = {
    "fontsize": "22",
    "fontname": "Helvetica",
    "bgcolor": "white",
    "pad": "0.7",
    "splines": "polyline",   # segmentos retos que se fixam na borda dos nos
    "nodesep": "0.8",
    "ranksep": "1.4",
    "dpi": "160",
}
cluster_attr = {
    "bgcolor": "#E8F4FD",
    "pencolor": "#3F8DDA",
    "fontsize": "15",
    "fontname": "Helvetica",
    "fontcolor": "#1A4B8C",
    "style": "rounded",
    "margin": "18",
}
node_attr = {"fontname": "Helvetica", "fontsize": "13"}
edge_attr = {"fontname": "Helvetica", "fontsize": "12"}

GREEN = "#1e8e3e"
RED = "#D13212"
PURPLE = "#7c3aed"
BLUE = "#3F8DDA"

with Diagram(
    "Policy-as-Code - repositorio central de regras + validacao no PR",
    filename="img/architecture",
    outformat=["png", "svg"],
    show=False,
    direction="LR",
    graph_attr=graph_attr,
    node_attr=node_attr,
    edge_attr=edge_attr,
):
    with Cluster("Repositorios consumidores (IaC)", graph_attr=cluster_attr):
        devs = Users("Desenvolvedores")
        repo_a = Github("App Repo A\n(Terraform/CFN)")
        repo_b = Github("App Repo B\n(Terraform/CFN)")

    with Cluster("Repositorio CENTRAL de regras", graph_attr=cluster_attr):
        central = Github("policy-as-code\n(regras por epico)")
        checkov = Terraform("Checkov\n(Terraform)")
        guard = Cloudformation("cfn-guard\n(CloudFormation)")
        central >> Edge(color="#8896a6") >> checkov
        central >> Edge(color="#8896a6") >> guard

    with Cluster("Validacao no Pull Request (GitHub Actions)", graph_attr=cluster_attr):
        gate = GithubActions("Policy Gate\n(reusable workflow)", group="core")
        decision = Decision("Conforme?", group="core")

    with Cluster("Conta de destino (AWS)", graph_attr=cluster_attr):
        deploy = GithubActions("Deploy pipeline", group="core")
        with Cluster("Recursos governados (exemplos)", graph_attr=cluster_attr):
            s3 = S3("S3 bucket")
            ec2 = EC2("EC2 instance")
            rds = RDS("RDS")
            kms = KMS("KMS key (CMK)")
            cfg = Config("AWS Config rule")

    blocked = StartEnd("Merge bloqueado")

    # Abertura do PR
    devs >> Edge(label="abre PR") >> repo_a

    # PR dispara o gate (dos repos consumidores)
    repo_a >> Edge(label="on: pull_request", color=PURPLE) >> gate
    repo_b >> Edge(color=PURPLE) >> gate

    # Gate consome as regras do repo central
    checkov >> Edge(label="regras (checkout)", style="dashed", color=BLUE) >> gate
    guard >> Edge(style="dashed", color=BLUE) >> gate

    # Decisao e saidas
    gate >> Edge(label="Checkov + cfn-guard") >> decision
    decision >> Edge(label="viola", color=RED) >> blocked
    decision >> Edge(label="conforme", color=GREEN) >> deploy

    # Feedback: PR reprovado volta para o desenvolvedor corrigir
    blocked >> Edge(label="corrige e reenvia", style="dashed", color=RED) >> devs

    # Deploy provisiona recursos conformes (exemplos de recursos governados)
    deploy >> Edge(label="provisiona\n(conforme)", color=GREEN) >> s3
    deploy >> Edge(color=GREEN) >> ec2
    deploy >> Edge(color=GREEN) >> rds
    deploy >> Edge(color=GREEN) >> kms
    deploy >> Edge(color=GREEN) >> cfg
