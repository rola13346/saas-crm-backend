# ADR-002: Sanctum vs. Passport for Authentication

Date: 2026-11-28

## Status

Accepted

## Context

Two kinds of clients need to log in to our API:

- Our own web app and mobile app.
- Third-party integrations.

Laravel has two tools for this. Sanctum is simple and fits our own apps. Passport (OAuth2) fits third-party integrations.

## Decision

We will **use both**:

- **Sanctum** for our own web and mobile apps.
- **Passport** for all third-party integrations.

## Consequences

**Good**

- Our own apps stay simple.
- Third parties connect in a standard, safe way.
- We can control or block each third party's access.

**Bad**

- Two systems to set up and maintain.
- Each route must use the right one, or it may be left unprotected.
