# Notes: Introduction to CI/CD + Jenkins
## Jenkins  
### What is CI? Benefits?
- Continuous Integration 
  - (trigger) updated code pushed to branch by developer e.g. dev branch
  - code needs to be tested,  passing these tests allows the branch to be merged to main branch
  - Developers integrate code changes at least daily.
  - Every integration is automatically built and tested.
  - Tools like Jenkins, GitHub Actions, GitLab CI/CD, CircleCI, and Travis CI are commonly used.
#### Benefits
- Early Detection of Bugs
- Automated testing catches issues as soon as they’re introduced.
- Faster Feedback
- Developers get immediate feedback, making debugging easier and quicker.
- Reduced Integration Problems
- Smaller, incremental changes are easier to manage and integrate.
- Improved Code Quality
- Frequent testing and code reviews help maintain high standards.
- Faster Release Cycles
- Teams can deliver new features and fixes faster due to streamlined workflows.
- Enhanced Collaboration
- Shared codebases and standardized processes promote teamwork.
- Deployment Confidence
- With every build being tested, deployments are less risky and more reliable.
### What is CD? Benefits?
- Continuous Deployment/ Delivery
- CD stands for Continuous Delivery or Continuous Deployment—two practices that extend Continuous Integration (CI) 
by automating the delivery or deployment of code to production or staging environments.
- Continuous Delivery
  - build software, turn it into an artefact awaiting deployment
  - deployment of the artefact requires manual approval  
  - Every change that passes CI tests is automatically prepared for release.
  - Deployment to production is manual (you decide when to release).
- Continuous Deployment
  - Every change that passes CI and testing is automatically deployed to production.
  - No human intervention; releases happen frequently, sometimes multiple times per day.
#### Benefits 
- Faster Time to Market
- Reduces the time between writing code and getting it into users' hands.
- Lower Risk Releases
- Smaller, frequent updates reduce the chances of major failures.
- Higher Quality
- Automated testing and staging environments ensure bugs are caught early.
- Improved Developer Productivity
- Less manual effort and fewer bottlenecks.
- Rapid User Feedback
- Frequent releases allow users to give quicker feedback, helping teams iterate faster.
- More Reliable Releases
- Consistent, repeatable deployments reduce human error.
- Better Team Morale
- Developers see their work in production quickly, boosting satisfaction and ownership.
### What is Jenkins?
- Jenkins is an open-source automation server widely used for Continuous Integration (CI) and Continuous Delivery/Deployment (CD). 
- It helps developers automate the process of building, testing, and deploying applications. 
### Why use Jenkins? Benefits of using Jenkins? Disadvantages?
#### Advantages
- automation
- extensibility - over 1800 plugins 
- scalibility - can distribute workload across agents/nodes
- community support 
- cross-platform  
#### Disadvantages
- can become complex 
### Stages of CI/CD pipeline with Jenkins
1. CI -> Source code management (SCM)
2. CI -> Build the code
3. CI -> Run the tests
4. CD -> Packaging into a deploymenr artefact
5. CD -> Deploy package & run 
6. CD -> Monitoring
### What alternatives are there for Jenkins? Why build a pipeline? Business value?
| Tool                    | Type                | Key Benefits                                                  |
|-------------------------|---------------------|---------------------------------------------------------------|
| **GitHub Actions**      | Cloud/Integrated    | Native to GitHub, easy to set up, YAML-based workflows        |
| **GitLab CI/CD**        | Cloud & Self-Hosted | Fully integrated with GitLab, strong built-in DevOps features |
| **CircleCI**            | Cloud/Hybrid        | Fast performance, strong Docker and caching support           |
| **Travis CI**           | Cloud               | Simple YAML-based config, good for open-source                |
| **Azure DevOps**        | Cloud & On-Prem     | Deep integration with Microsoft ecosystem                     |
| **Bitbucket Pipelines** | Cloud               | Seamless with Bitbucket repos, simple setup                   |
| **TeamCity**            | Self-hosted         | JetBrains tool with powerful config options                   |
| **Drone CI**            | Cloud & Self-Hosted | Container-native, easy Kubernetes integration                 |
| **Argo CD / Flux**      | Kubernetes-Native   | GitOps-driven deployment for Kubernetes environments          |

- Business value 
| Value                              | Explanation                                                          |
|------------------------------------|----------------------------------------------------------------------|
| **Faster Time to Market**          | Rapid release cycles keep you competitive.                           |
| **Higher Product Quality**         | Fewer bugs reach production thanks to continuous testing.            |
| **Increased Developer Efficiency** | Automation frees developers to focus on innovation.                  |
| **Lower Risk Deployments**         | Small, frequent changes are easier to validate and roll back.        |
| **Improved Customer Satisfaction** | Quick response to user feedback and faster feature delivery.         |
| **Scalability**                    | Easily manage multiple projects and environments as your team grows. |

### Create a general diagram of CICD
Understand SDLC workflow: plan, design, develop, deploy
