# ADR-001: Single vs. Multi-Database Tenancy for SaaS

Date: 2026-11-28

## Status

Accepted

## Context

Our app serves many customers. We need to decide where each customer's data lives: all together in one database, or each customer in their own database. Our customers want their data kept fully apart from others, and some need their own backups.

## Decision

We will give **each customer their own database**. One small main database keeps a list of all customers.

When a request comes in, the app finds out which customer it is from and connects to their database. When we change the database structure, one tool updates every customer's database.

## Consequences

**Good**

- Each customer's data is fully separate, so no one can see someone else's data.
- We can back up, restore or delete one customer's data easily.
- A busy customer won't slow down everyone else.

**Bad**

- It costs more, because every database has its own running cost.
- There is more to manage: many databases to set up, watch and update.
