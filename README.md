# Azure Enterprise Landing Zone

## Solution Intent

Create a simplified multi-subscription or multi-vnet Azure environment that allows a single vnet to be used to control on-premise routing and security. 

This stack should codify Microsoft Azure Best Practices

_put a diagram of the solution here_

## Stack Details

This stack creates the following resources:

* /22 vnet
* 3 subnets: a /24 data subnet, /24 web subnet, and a /23 apps subnet
* a web security group
* data, web, app availability sets
