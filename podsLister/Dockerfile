# Set python image
FROM python:3.6
MAINTAINER XenonStack

# Create the App directories
RUN mkdir -p /k8s-pod-lister/src

# Set the working directory of the script
WORKDIR /k8s-pod-lister

# Install dependencies
COPY requirements.txt /k8s-pod-lister
COPY app.py /k8s-pod-lister
RUN pip install --no-cache-dir -r requirements.txt

# Set port to be exposed
EXPOSE 5035

# Define environment variable
ENV APP_ENV development

# Run app.py when the container launches
CMD ["python", "app.py"]