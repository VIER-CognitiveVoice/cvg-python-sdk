from setuptools import setup, find_packages  # noqa: H301
import os

if "VERSION" in os.environ and len(os.environ["VERSION"]) > 0:
    version = os.environ["VERSION"]
else:
    version = "0.0.1-devel"

with open("requirements.txt") as f:
    requirements = [req.strip() for req in f.readlines() if len(req) > 0]

setup(
    name="cvg-python-sdk",
    version=version,
    description="VIER Cognitive Voice Gateway SDK",
    author="VIER GmbH",
    author_email="support@vier.ai",
    url="https://cognitivevoice.io",
    keywords=["OpenAPI", "OpenAPI-Generator", "VIER", "VIER Cognitive Voice Gateway SDK"],
    python_requires=">=3.6",
    install_requires=requirements,
    packages=find_packages(exclude=["test", "tests"]),
    include_package_data=True,
    license="MIT",
)
