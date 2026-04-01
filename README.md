# LinuxConsumptionBicep

> ⚠️ **This repository is for demo purposes only.** Use it to create a Linux Consumption function app as a starting point for demonstrating the **Azure-Upgrade skill** in the Azure Skills plugin for Copilot CLI. Do not use it for production workloads.

## Overview

Azure has removed the ability to create new Linux Consumption function apps from the Azure Portal. You must use Bicep, ARM templates, or the Azure CLI to create them. This repository provides a Bicep template to quickly provision a Linux Consumption function app so you can demonstrate upgrading it to a [Flex Consumption](https://learn.microsoft.com/en-us/azure/azure-functions/flex-consumption-plan) app using the **Azure-Upgrade skill**.

### Why Migrate from Linux Consumption to Flex Consumption?

- **No new features** are being added to Linux Consumption (feature freeze took effect September 30, 2025).
- **Linux Consumption is fully retired** on September 30, 2028 — all apps must be migrated before then.
- **Flex Consumption** offers faster cold starts, per-function scaling, VNET integration, higher scale limits (up to 1,000 instances), and configurable memory sizes.

## Prerequisites

Before you begin, ensure you have:

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) installed and authenticated (`az login`)
- An Azure subscription with permissions to create resource groups and function apps
- [GitHub Copilot CLI](https://docs.github.com/en/copilot/github-copilot-in-the-cli/about-github-copilot-in-the-cli) (or a compatible Copilot CLI / agent host) installed and configured
- The **Azure Skills plugin** installed in your Copilot CLI (see [Installation](#installing-the-azure-skills-plugin) below)

## Step 1: Deploy the Linux Consumption Function App Using Bicep

Clone this repository and deploy the included Bicep template to create a Linux Consumption function app in your Azure subscription:

```bash
git clone https://github.com/nzthiago/LinuxConsumptionBicep.git
cd LinuxConsumptionBicep
```

Create a resource group (or use an existing one):

```bash
az group create --name <RESOURCE_GROUP_NAME> --location <LOCATION>
```

Deploy the Bicep template:

```bash
az deployment group create \
  --resource-group <RESOURCE_GROUP_NAME> \
  --template-file main.bicep
```

> **Note:** Replace `<RESOURCE_GROUP_NAME>` and `<LOCATION>` (e.g., `eastus`) with your desired values. The deployment will output the name of the newly created Linux Consumption function app.

## Step 2: Install the Azure Skills Plugin

The Azure Skills plugin adds specialized Azure skills to your Copilot CLI. To install it:

```
/plugin marketplace add microsoft/azure-skills
/plugin install azure@azure-skills
/mcp reload
/mcp status
```

Verify the plugin is active before continuing.

## Step 3: Upgrade to Flex Consumption Using the Azure-Upgrade Skill

With the Linux Consumption app deployed and the Azure Skills plugin installed, you can now use the **Azure-Upgrade skill** to guide you through migrating to Flex Consumption.

In your Copilot CLI session, use a natural language prompt such as:

```
Upgrade my Linux Consumption function app to Flex Consumption
```

The Azure-Upgrade skill will:

1. **List eligible Linux Consumption apps** in your subscription.
2. **Assess readiness** — checking region support, runtime compatibility, and configuration.
3. **Guide you through creating a new Flex Consumption app** configured to match your source app (settings, identity, storage, etc.).
4. **Validate** the new app before you cut over traffic.

> No in-place upgrade is performed — a parallel Flex Consumption app is created so you control the switchover timing.

## Additional Resources

- 📖 [Migrate Consumption plan apps to Flex Consumption — Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-functions/migration/migrate-plan-consumption-to-flex)
- 📖 [Flex Consumption plan overview](https://learn.microsoft.com/en-us/azure/azure-functions/flex-consumption-plan)
- 📖 [az functionapp flex-migration CLI reference](https://learn.microsoft.com/en-us/cli/azure/functionapp/flex-migration?view=azure-cli-latest)
- 📖 [Azure Skills Plugin — Getting Started](https://devblogs.microsoft.com/all-things-azure/azure-skills-plugin-lets-get-started/)
