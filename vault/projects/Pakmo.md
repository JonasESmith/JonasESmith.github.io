---
title: "Pakmo"
description: "Shipment, order, customer tracker"
order: 7
draft: false
url: "https://pakmo-e7476.web.app/"
icon: "box.png"
start: "2023-06-01"
platforms:
  - "ios"
  - "android"
  - "web"
  - "macos"
technologies:
  - name: "Flutter"
    url: "https://flutter.dev/"
  - name: "React"
  - name: "ShipStation"
  - name: "Zenventory"
  - name: "Bloc"
  - name: "FlutterModular"
  - name: "Python"
  - name: "PHP"
  - name: "SQL"
gallery:
  - "pakmo_01.png"
  - "pakmo_02.png"
---

[Pakmo.co](https://pakmo.co/) is a middle-man shipping service: clients send their inventory to Pakmo warehouses, and Pakmo picks, packs and ships their orders.

## Built for the warehouse floor

The Pakmo app was built for manager-level staff who spend their day on the warehouse floor, not behind a desk. From a phone or tablet, a manager can see every order at a glance:

- **Blocked orders** that can't ship until something is resolved.
- **Flagged orders** that need a closer look before they go out.
- **Where everything stands:** the current status of each order, so problems are caught on the floor, as they happen.

Managers can also see current inventory numbers for items waiting to arrive at Pakmo warehouses, without walking back to an office computer.

## How the data flows

Order and inventory data lives in two systems: **Zenventory** for inventory and **ShipStation** for orders and shipments. Rather than have every device query both, a server pulls the data from their APIs, stores it, and sends it on to the app:

```
Zenventory ─┐
            ├──► Pakmo server ──► manager app (phone, tablet, web)
ShipStation ┘
```

One place to combine the two sources meant the app stayed fast and simple, and Zenventory and ShipStation each saw a single steady consumer instead of one per device.

## Automation scripts

Scripts scan orders and client data for signs of fraud and flag suspicious orders before they ship.

## Onboarding site

For new clients, I built the public landing pages and their sign-up forms. Each form submission introduced the prospective client to a sales rep, who took the onboarding from there.
