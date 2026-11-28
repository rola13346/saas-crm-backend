# ADR-003: Tenancy Package vs. Building It Ourselves

Date: 2026-11-28

## Status

Accepted

## Context

In ADR-001 we decided to give each customer their own database. Now we need to decide how to build this in Laravel:

- Build it ourselves: switch databases, create new customer databases and run migrations with our own code.
- Use a ready-made package that already does this.

## Decision

We will use the **stancl/tenancy** package (Tenancy for Laravel).

It already handles:

- Finding the customer from the domain or subdomain.
- Switching to that customer's database on each request.
- Creating a new database when a customer signs up.
- Running migrations for every customer's database.

## Consequences

**Good**

- Much faster to build than writing it ourselves.
- Well known and widely used in the Laravel community, so there are fewer bugs.
- Also keeps cache, files and queues separate for each customer.

**Bad**

- We depend on an outside package and must follow its updates.
- The team needs time to learn how the package works.
