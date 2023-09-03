# terraform-aws

## Directroy Structure

```
.
├── infra-base
├── infra-ondemand
└── sandbox
```

**infra-base**:
A workspace manages essential resources like vpc, which should not be destroyed.

**infra-ondemand**:
A directory contains multiple workspaces. Each workspace manages essential but expensive resources like alb, which could be destroyed when not in use.

**sandbox**:
A directory contains multiple workspaces for general.
