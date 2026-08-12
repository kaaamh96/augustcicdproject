
CI/CD Flask Application
Project Overview
This project demonstrates a simple CI/CD pipeline for a containerised Python Flask application.
The project uses GitHub Actions to automate testing; Docker image builds and delivery to Docker Hub.
The aim of the project was to understand how Continuous Integration (CI) and Continuous Delivery (CD) work together in a practical DevOps workflow.
 
Architecture
 



 
Technologies Used
•	Python
•	Flask
•	Docker
•	Docker Hub
•	Git
•	GitHub
•	GitHub Actions
•	pytest
•	YAML
 
Continuous Integration (CI)
The CI pipeline is defined in .github/workflows/ci.yml.
The workflow is triggered when:
•	Code is pushed to the main branch 
•	A pull request targets the main branch 
The pipeline:
1.	Checks out the repository. 
2.	Sets up Python 3.12. 
3.	Installs Flask and pytest. 
4.	Runs the automated tests using pytest. 
The purpose of the CI pipeline is to automatically verify that changes to the application pass the defined tests before they are considered ready for delivery

 




 
Continuous Delivery (CD)

The CD pipeline is defined in .github/workflows/docker-publish.yml.
When code is pushed to the main branch, GitHub Actions:
1.	Checks out the repository. 
2.	Logs into Docker Hub using securely stored GitHub credentials. 
3.	Builds the Docker image. 
4.	Tags the image. 
5.	Pushes the image to Docker Hub. 
This demonstrates automated delivery of a containerised application to a Docker registry.

 
	

 

 
Automated Testing
The application is tested using pytest.
The test checks that the Flask application's / endpoint:
•	Responds successfully with HTTP status 200
•	Returns the expected application message
Example:
def test_homepage():
    client = app.test_client()

    response = client.get('/')

    assert response.status_code == 200
    assert b'Hello, World! This application was deployed using CI/CD.' in response.data
 
A CI Test Failure I Encountered
During development, the CI pipeline initially failed because of a small difference between the application output and the expected test output.
The application returned:
Hello, World! This application was deployed using CI/CD.
While the test was checking for:
Hello, World! this application was deployed using CI/CD.
The only difference was the capitalisation of the "T" in This.
This demonstrated an important benefit of CI: automated tests can identify small issues immediately when code is pushed.
After correcting the test, the pipeline completed successfully.
 

 
Docker
The Flask application is packaged into a Docker image using the project's Dockerfile.
The Dockerfile:
1.	Uses Python 3.12.
2.	Creates /app as the working directory.
3.	Copies the application files.
4.	Installs Flask.
5.	Exposes port 5002.
6.	Starts the Flask application.
The Docker image is built and pushed during the CD processes.

 
Security
Docker Hub authentication is handled using GitHub repository secrets and variables rather than hardcoding credentials in the workflow.
The workflow uses:
DOCKER_USERNAME
DOCKER_PASSWORD
DOCKER_PASSWORD contains a Docker Hub access token rather than the account password for safe deployment.
The credentials are referenced in GitHub Actions using:
${{ vars.DOCKER_USERNAME }}
${{ secrets.DOCKER_PASSWORD }}
No credentials are stored in the source code.
 
Project Structure
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




 
 
CI/CD Workflow Summary
CI
Push / Pull Request
        |
        
GitHub Actions
        |
        
Run automated tests
        |
          
Success / Failure
CD
Push to main
      |
      
GitHub Actions
      |
      
Build Docker image
      |
      
Log in to   Docker Hub
      |
      
Push image
      |
      
Docker Hub
 
What I Learned
This project helped me get  a practical understanding of CI/CD rather than just learning the concepts theoretically.
Key areas I worked with include:
•	Creating GitHub Actions workflows using YAML
•	Understanding CI and CD
•	Automating tests with pytest
•	Building Docker images
•	Publishing Docker images to Docker Hub
•	Using GitHub Secrets for sensitive credentials and Github environmental variables
•	Understanding how code changes can automatically trigger a pipeline
•	Troubleshooting failed CI tests ( syntax errors and code mismatches)
•	Understanding the role of automated testing before application delivery
One of the main lessons from the project was that CI is not simply about making a pipeline turn green. A failed test can provide useful feedback and prevent incorrect changes from progressing through the delivery process.
 
Project Outcome
The completed project demonstrates a basic but functional DevOps workflow where application changes can be:
tested → containerised → built → and automatically delivered to Docker Hub.
This provides a foundation for extending the project into a full cloud deployment pipeline.
<img width="468" height="250" alt="image" src="https://github.com/user-attachments/assets/5bbfaf90-1eec-4513-ad6b-df732a15ebaa" />
