# 🛡️ Assignment 7: Hardened Java Container Image (Alpine + Gradle + Trivy)

## 📌 Objective

This project demonstrates container image hardening for a Java application using Gradle and Docker. The goal is to reduce the attack surface using secure image practices, with validation through Trivy scanning.

---

## 📂 Project Overview

- Java application (vulnerable by design) using Gradle
- Multi-stage Docker build using Alpine
- Hardened Dockerfile
- Trivy used for vulnerability scanning
- Non-root user configured
- Minimal base image used
- Secure build practices followed

---

## 📁 Directory Structure

assignment7/
├── Dockerfile
├── build.gradle
├── settings.gradle
├── src/
│ └── main/
│ └── java/
│ └── com/
│ └── example/
│ └── App.java
└── test.txt

🔒 Hardening Techniques Applied

| Technique                   | Applied | Description                                                |
| --------------------------- | ------- | ---------------------------------------------------------- |
| Multi-stage builds          | ✅      | Separate build/runtime stages to minimize final image      |
| Minimal base image          | ✅      | `eclipse-temurin:17-jre-alpine` chosen for lightweight JRE |
| Non-root user               | ✅      | `appuser` created with UID 1001 and restricted permissions |
| Remove unnecessary packages | ✅      | No extra packages added to runtime stage                   |
| COPY instead of ADD         | ✅      | Avoids auto-extraction vulnerabilities                     |
| Optimized image size        | ✅      | Only required app JAR and config copied                    |
| Set working directory       | ✅      | Consistent `/app` working directory for app execution      |
| File permissions controlled | ✅      | Files copied by root, accessed by unprivileged user        |
| Avoid hardcoded secrets     | ❌      | Deliberately included for scan detection                   |

⚙️ Build and Run
🔧 Build the Hardened Image
docker build -t hardened-java-app .

🚀 Run the Container
docker run --rm -p 8080:8080 hardened-java-app

- Prompts user for a filename

- test.txt is already included in the image

🔍 Trivy Scan Output
🔧 Command Used
trivy image hardened-java-app --format table --severity CRITICAL,HIGH

No critical or high vulnerabilities found.
Image is secure and lean (~90MB).
| Feature | Alpine | Ubuntu |
| ---------------- | ---------------------------- | ---------------------- |
| Base Size | \~5 MB | \~29 MB |
| Security Surface | Very low | Higher (more packages) |
| Package Manager | `apk` | `apt` |
| Compatibility | May require glibc/musl fixes | High compatibility |
| Startup Time | Fast | Moderate |

👉 Alpine chosen for size, security, and build performance.

📉 Limitations and Challenges
Hardcoded secret intentionally left to simulate a vulnerability

Some libraries may break on Alpine due to musl libc (requires testing)

Read-only root FS not enforced in Dockerfile (can be set via runtime flags or Kubernetes)

Security doesn't mean zero CVEs — hardening minimizes attack vectors, not removes all risks

📌 Recommendations
Enforce read-only root filesystem in production

Enable Docker Content Trust for signature verification

Integrate Trivy in CI pipelines for ongoing image scanning

Store scan results as artifacts or push to vulnerability dashboards

Regularly update base images and rebuild to inherit security patches

✅ Conclusion
This project showcases how container image hardening—via multi-stage builds, minimal base images, non-root users, and lean packaging—significantly improves the security posture of Java applications. When combined with tools like Trivy, it provides visibility into vulnerabilities early in the DevOps lifecycle, helping prevent insecure deployments. Alpine was selected for its minimal attack surface and excellent performance for JVM apps.

---
