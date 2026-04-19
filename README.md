## 1. Git Repository Initialization and Push

Created a Git repository named `Technical-Round-Jobaxle` and initialized the main branch.  
Added a file `testpush.txt` with the content:  
"This is a new file for pushing the code for the first question."

Committed the changes with a proper message and pushed the code to the remote GitHub repository.


## 2. Branching Strategy (Feature, Develop, Main)

Created a branching strategy using `main`, `develop`, and `feature` branches.

- Created `develop` and `feature` branches from `main`.
- Made changes to `testpush.txt` in both branches to simulate parallel team work.
- Merged `feature` → `develop` and then `develop` → `main`.
- This simulated a basic team workflow with feature development and integration before production.


## 3. Merge Conflict Resolution

Simulated a merge conflict scenario between `feature` and `develop` branches by modifying the same file (`testpush.txt`) in both branches with different content.

During the merge process, a conflict occurred which was resolved manually by editing the file and choosing the final desired content.

After resolving the conflict, the file was staged and committed, and the updated branch was successfully merged.

## 4. Optimized Dockerfile (Small and Secure Image)

Created a multi-stage Dockerfile to optimize image size and improve security.

- Used a `node:20-alpine` builder stage to install dependencies and build the application.
- Separated build and runtime stages to avoid unnecessary build tools in the final image.
- Used a `distroless` base image for the final stage to ensure a minimal and secure runtime environment.
- Only copied the required build artifacts from the builder stage to reduce image size and attack surface.

## 5. Container Execution and Debugging

Ran a Prometheus container without exposing the required ports, which caused issues while accessing the application.

During runtime, the container was running but the service was not reachable externally due to missing port mapping.

Error observed:
- Application was not accessible on `localhost:9090`.

Root cause:
- Ports were not exposed while running the container.

Fix applied:
- Re-ran the container with correct port mapping using `-p 9090:9090`.




## 6. Multi-Container Setup using Docker Compose

Created a multi-container setup using Docker Compose to manage the application and database services.

- The compose file is named `docker-compose.yaml` and is located in the `main` branch.
- Defined an `app` service using Node.js to run the application.
- Added a `db` service using PostgreSQL for database support.
- Used volumes to persist database data.
- Services are connected using Docker networking and `depends_on` for proper startup order.




## 7. CI Pipeline using GitHub Actions

Configured a CI pipeline using GitHub Actions to automate build and testing.

- The workflow file is located at `.github/workflows/ci.yaml`.
- Pipeline triggers on push to `main` and `develop` branches, and on pull requests.
- Uses Ubuntu runner environment.
- Sets up Node.js (version 20).
- Installs dependencies using `npm install`.
- Runs tests using `npm test`.



## 8. Deployment Automation using Bash Script

Created a bash script to automate repetitive deployment steps.

- The script is named `automate_deployment.sh` and is available in the repository.
- It automates the process of pulling the latest code from the repository or cloning it if not present.
- Installs project dependencies using `npm install`.
- Builds the application using `npm run build`.
- Restarts the application using PM2 to ensure zero manual intervention during deployment.



## 9. Secure Configuration of Environment Variables

Configured environment variables securely using a `.env` file.

- Sensitive data such as database credentials and JWT secrets are stored in a `.env` file.
- The `.env` file is excluded from version control using `.gitignore` to prevent exposure in GitHub.
- Application reads configuration values from environment variables instead of hardcoding them.




## 10. Nginx Reverse Proxy Setup

Configured Nginx as a reverse proxy for the backend service to manage incoming traffic.

- The Nginx configuration file is `nginx.conf`.
- Updated Docker Compose to include an `nginx` service.
- Nginx forwards incoming requests on port 80 to the backend `app` service running on port 3000.
- Added proxy headers to preserve client information.



## 11. Static Frontend Deployment on Netlify

Deployed a static frontend application using Netlify.

- The frontend consists of basic HTML, CSS, and JavaScript files located in the `frontend/` directory.
- Installed Netlify CLI and used it to deploy the application.
- Published the site and verified successful deployment using the generated Netlify URL.



## 12. System Log Analysis and Root Cause Identification

Analyzed kubelet service logs to identify a node-level failure issue.

- The logs are stored in `kubelet.logs`.
- The kubelet service was failing to start due to container runtime connectivity issues.
- Error indicated that kubelet could not connect to `containerd` via the socket `/run/containerd/containerd.sock`.
- This caused the node to enter a `NotReady` state.

Root cause:
- Container runtime (containerd) was not running or not accessible.

Fix applied:
- Restarted the kubelet service to restore connectivity and recover node state.




## 13. Container Debugging using Logs

Analyzed application logs to debug a failing container.

- The logs are stored in `failing_container.logs`. We got the logs using docker container logs <container_id>.
- The application failed to start due to a missing environment variable `DB_HOST`.
- This caused a configuration failure during startup, resulting in process termination.

Root cause:
- Missing required environment variable for database connection.

Fix applied:
- Provided the required environment variable (`DB_HOST`) using proper environment configuration (e.g., `.env` file or runtime environment settings).
- After adding the missing configuration, the container started successfully.



## 14. CI/CD Pipeline using GitHub Actions

Configured a CI/CD pipeline using GitHub Actions to automate build, test, and deployment.

- The workflow file is located at `.github/workflows/cicd.yaml`.
- Pipeline triggers on push to the `main` branch.
- Steps include:
  - Checkout repository code
  - Setup Node.js environment (version 20)
  - Install dependencies using `npm install`
  - Build the application using `npm run build`
  - Run tests using `npm test`
  - Deploy the application (simulated deployment step)




## 15. End-to-End Deployment Lifecycle and Failure Points

The end-to-end deployment lifecycle describes the flow of an application from development to production, ensuring continuous integration, delivery, and monitoring.

### Lifecycle Flow:

1. **Code Development**
   - Developers write and commit code to a version control system (Git).
   - Code is pushed to branches like `feature`, `develop`, and `main`.

2. **Continuous Integration (CI)**
   - On every push or pull request, a CI pipeline is triggered (GitHub Actions).
   - Steps include:
     - Installing dependencies
     - Building the application
     - Running automated tests
   - This ensures that only valid and tested code proceeds further.

3. **Artifact Build / Packaging**
   - The application is packaged into a deployable format (e.g., Docker image or build output).
   - Optimized images may be created using multi-stage builds.

4. **Continuous Deployment (CD)**
   - After successful CI, the application is deployed to staging or production environments.
   - This can involve Docker, Kubernetes, Netlify, or cloud services.
   - Environment variables and configurations are injected during this stage.

5. **Runtime / Production Execution**
   - The application runs in the production environment.
   - Services like databases, APIs, and reverse proxies interact with the application.

6. **Monitoring and Logging**
   - Logs and metrics are collected for observability.
   - Tools help detect failures and performance issues in real time.

---

### Possible Failure Points:

- **Code Level**
  - Syntax errors or logical bugs
  - Missing dependencies

- **CI Stage**
  - Build failures
  - Test failures
  - Dependency installation issues

- **Build/Container Stage**
  - Incorrect Dockerfile configuration
  - Missing files in build context
  - Large or insecure images

- **Deployment Stage**
  - Wrong environment variables
  - Port conflicts
  - Image pull failures
  - Misconfigured CI/CD pipelines

- **Runtime Stage**
  - Database connection failures
  - Memory/CPU exhaustion
  - Service crashes or restart loops
  - Network or DNS issues

- **Monitoring Stage**
  - Missing logs or metrics
  - Delayed failure detection


