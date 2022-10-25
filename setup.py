from setuptools import setup, find_packages  # noqa: H301

setup(
    name="cvg-python-sdk",
    version="0.0.1-devel",
    description="VIER Cognitive Voice Gateway SDK",
    author="VIER GmbH",
    author_email="support@vier.ai",
    url="https://cognitivevoice.io",
    keywords=["OpenAPI", "OpenAPI-Generator", "VIER", "VIER Cognitive Voice Gateway SDK"],
    python_requires=">=3.6",
    install_requires=[
        'python_dateutil >= 2.5.3',
        'urllib3 >= 1.25.3',
    ],
    packages=find_packages(exclude=["test", "tests"]),
    package_data={'': ['requirements.txt']},
    include_package_data=True,
    license="MIT",
)
