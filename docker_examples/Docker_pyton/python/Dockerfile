# Use an official Ubuntu base image with minimal packages
FROM ubuntu:20.04

# Set the working directory
WORKDIR /var/infrastructure

# Update the package list and install necessary packages
# This includes curl for downloading AWS CLI and software-properties-common for adding new repositories
RUN apt-get update && \
    apt-get install -y curl software-properties-common unzip locales locales-all jq gettext-base

# Install Python3 and pip
# This ensures you have the latest version of Python3 and pip
RUN apt-get install -y python3 python3-pip

RUN pip install cfn-lint yamllint

# Install AWS CLI
# The AWS CLI version can be updated by changing the version number in the command below
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Clean up the package lidst to reduce the image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the default locale to en_US
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:us

