# Blue–Green Deployment – EC2 (Java) – Learning Notes

This folder contains my notes and example scripts for doing **blue–green deployments** of a Java app on **EC2** in two ways:

1. From **laptop build → EC2** (simple learning pattern)
2. From **CI/CD + Artifactory → EC2** (more realistic)

Goal: deploy a new version (**Green**) while the old version (**Blue**) still serves traffic, then switch traffic with minimal/zero downtime.

---

## 1. Laptop → EC2 (simple learning flow)

### High-level

1. Build JAR **locally** on laptop (Gradle).
2. Copy JAR to **Blue/Green EC2 directory** via `scp` (e.g. `/app/blue`, `/app/green`).
3. SSH into EC2 and start app with `nohup java -jar`.
4. Manually (or by script) switch traffic from Blue → Green (LB / nginx).

### Script: `deploy_from_laptop.sh`

- Builds with `./gradlew clean build`.
- Copies the JAR to `/app/blue` or `/app/green` on EC2.
- Starts the app with `nohup java -jar my-app.jar > app.log 2>&1 &`.

Notes:

- This is **for learning only**. In real setups, builds run in CI, not on the laptop.
- Blue and Green can be:
  - two EC2 instances (different IPs, same port), or
  - two ports on one EC2 (fronted by nginx / ALB).

---

## 2. CI/CD + Artifactory → EC2 (more realistic)

### High-level

1. **Developer pushes code** → Git.
2. **CI build**:
   - runs `./gradlew clean build`
   - creates `my-app-<version>.jar`
3. **CI publishes JAR** to **Artifactory**.
4. **CI deploys to Green EC2**:
   - chooses version (`VERSION`)
   - knows `JAR_NAME` and `JAR_URL`
   - uses SSH to run a **remote deploy script** on Green, passing those args
5. **Remote deploy script (on Green)**:
   - downloads JAR from Artifactory into `/app/green`
   - starts app with `nohup java -jar ... &`
6. **ALB / CI health checks** Green.
7. **ALB switches traffic** from Blue target group → Green target group.
8. Optionally scale down / stop Blue.

> The **Java process** is always started on **Green EC2** by the remote script, not on the CI runner.

### Script: `remote_deploy_green.sh` (runs on Green EC2)

- Lives on the Green EC2 instance (e.g. `/app/remote_deploy_green.sh`).
- Accepts:
  - `$1` = JAR file name (e.g. `my-app-1.2.3.jar`)
  - `$2` = full Artifactory URL to that JAR
- Changes into `/app/green`, downloads the JAR, and starts it with `nohup java -jar`.

### Script: `ci_deploy_to_green.sh` (runs in CI)

- Runs inside the CI pipeline (Jenkins, GitLab CI, GitHub Actions, etc.).
- Knows:
  - `VERSION`, `JAR_NAME`, `JAR_URL`
  - `GREEN_SERVER` (EC2 host) and SSH key
- Uses `ssh` to call `remote_deploy_green.sh` on the Green EC2:
  - passes `JAR_NAME` and `JAR_URL` as arguments.

---

## 3. Concept: EC2 vs ECS Blue–Green

- **EC2 + JAR**:
  - Version = JAR in Artifactory.
  - Deploy = SSH to Green EC2, run `remote_deploy_green.sh`.
  - Switch = ALB target group Blue → Green.

- **ECS + Docker**:
  - Version = Docker image tag + ECS task definition revision.
  - Deploy = ECS/CodeDeploy runs new tasks in a Green target group.
  - Switch = ALB/CodeDeploy shifts traffic Blue TG → Green TG.

Same idea: **deploy new version to Green, health check, then switch traffic** while Blue stays available for rollback.
