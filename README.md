# CI/CD Flask Application

## Project Overview

This project demonstrates a simple CI/CD pipeline for a containerised Python Flask application.

The project uses GitHub Actions to automate testing, Docker image builds and delivery to Docker Hub.

The aim of the project was to understand how Continuous Integration (CI) and Continuous Delivery (CD) work together in a practical DevOps workflow.

---

Architecture


<img width="412" height="718" alt="image" src="https://github.com/user-attachments/assets/f3e8906b-e1f7-40be-b97a-c35820e5f82c" />





           


## Technologies Used


•	Python
•	Flask
•	Docker
•	Docker Hub
•	Git
•	GitHub
•	GitHub Actions
•	pytest
•	YAML
 
## Continuous Integration (CI)

The CI pipeline is defined in:

.github/workflows/ci.yml

The workflow is triggered when:

Code is pushed to the main branch
A pull request targets the main branch

The pipeline performs the following steps:

Checks out the repository.
Sets up Python 3.12.
Installs Flask and pytest.
Runs the automated tests using pytest.

The purpose of the CI pipeline is to automatically verify that changes to the application pass the defined tests before they are considered ready for delivery.



```text
Push / Pull Request
        |
        v
GitHub Actions
        |
        v
Checkout repository
        |
        v
Set up Python 3.12
        |
        v
Install Flask + pytest
        |
        v
Run pytest
        |
        v
Success / Failure


```



## Continuous Delivery (CD)

The CD pipeline is defined in:

.github/workflows/docker-publish.yml

When code is pushed to the main branch, GitHub Actions:

Checks out the repository.
Logs into Docker Hub using securely stored GitHub credentials.
Builds the Docker image.
Tags the image.
Pushes the image to Docker Hub.

This demonstrates automated delivery of a containerised application to a Docker registry.


```text

Push to main
     |
     v
GitHub Actions
     |
     v
Checkout repository
     |
     v
Log in to Docker Hub
     |
     v
Build Docker image
     |
     v
Tag image
     |
     v
Push image
     |
     v
Docker Hub 


```


## Automated Testing

The application is tested using `pytest`.

The test checks that the Flask application's `/` endpoint:
* Responds successfully with HTTP status `200`
* Returns the expected application message

```python
def test_homepage():
    client = app.test_client()

    response = client.get('/')

    assert response.status_code == 200
    assert b'Hello, World! This application was deployed using CI/CD.' in response.data 

```

## A CI Test Failure I Encountered

During development, the CI pipeline initially failed because of a small difference between the application output and the expected test output.

The application returned:

Hello, World! This application was deployed using CI/CD.

While the test was checking for:

Hello, World! this application was deployed using CI/CD.

The only difference was the capitalisation of the "T" in This.

This demonstrated an important benefit of CI: automated tests can identify small issues immediately when code is pushed.

After correcting the test, the pipeline completed successfully.

This was a useful reminder that automated testing is not simply about making a pipeline turn green. A failed test provides useful feedback and can prevent incorrect changes from progressing through the delivery process.




## Docker

The Flask application is packaged into a Docker image using the project's Dockerfile.

The Dockerfile:

Uses Python 3.12.
Creates /app as the working directory.
Copies the application files.
Installs Flask.
Exposes port 5002.
Starts the Flask application.

The Docker image is built and pushed during the CD process.



 
## Security

Docker Hub authentication is handled using GitHub repository secrets and variables rather than hardcoding credentials in the workflow.

The workflow uses:

DOCKER_USERNAME
DOCKER_PASSWORD

DOCKER_USERNAME is stored as a GitHub repository variable.

DOCKER_PASSWORD contains a Docker Hub access token stored securely as a GitHub repository secret rather than using the Docker Hub account password.

The credentials are referenced in GitHub Actions using:

username: ${{ vars.DOCKER_USERNAME }}
password: ${{ secrets.DOCKER_PASSWORD }}

No credentials are stored directly in the source code.





## Project folder Structure

```text

augustcicdproject/
│
├── app.py
├── Dockerfile
├── test_app.py
├── README.md
│
└── .github/
    └── workflows/
        ├── ci.yml
        └── docker-publish.yml
 ```

 
## CI/CD Workflow Summary


### Continuous Integration
```text
Push / Pull Request
        |
        v
GitHub Actions
        |
        v
Run automated tests
        |
        v
Success / Failure

```


### Continuous Delivery
```text
Push to main
        |
        v
GitHub Actions
        |
        v
Build Docker image
        |
        v
Log in to Docker Hub
        |
        v
Push image
        |
        v
Docker Hub
 
```



## What I Learned

This project helped me develop a practical understanding of CI/CD rather than just learning the concepts theoretically.

Key areas I worked with include:

* Creating GitHub Actions workflows using YAML
- Understanding CI and CD
- Automating tests with pytest
- Building Docker images
- Publishing Docker images to Docker Hub
- Using GitHub Secrets for sensitive credentials
Using GitHub repository variables
- Understanding how code changes can automatically trigger a pipeline
- Troubleshooting failed CI tests, including syntax errors and code mismatches
- Understanding the role of automated testing before application delivery

One of the main lessons from the project was that CI is not simply about making a pipeline turn green. A failed test can provide useful feedback and prevent incorrect changes from progressing through the delivery process.


## Project Outcome

The completed project demonstrates a basic but functional DevOps workflow where application changes can be:

tested → containerised → built → and automatically delivered to Docker Hub.

The project provides a foundation for extending the workflow into a full cloud deployment pipeline.





## Screenshots


CI Pipeline

Screenshot showing the successful CI workflow and automated tests.

<img width="452" height="235" alt="image" src="https://github.com/user-attachments/assets/47957b46-28e6-40b9-92ec-47cc5d2e576d" />





CD Pipeline

Screenshot showing the successful Docker build and push workflow.



<img width="847" height="504" alt="image" src="https://github.com/user-attachments/assets/a491c2e6-c086-484e-9085-0fc51a36beab" />









Docker Hub

Screenshot showing the Docker image successfully published to Docker Hub.

<img width="527" height="575" alt="image" src="https://github.com/user-attachments/assets/db9fa4c7-795d-417b-bf99-61b15c8a38d9" />

 
