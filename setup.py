from setuptools import setup, find_packages

setup(
    name="bike-sharing-api",
    version="1.0.0",
    packages=find_packages(),
    install_requires=[
        "fastapi",
        "uvicorn",
        "pydantic",
        "numpy",
        "scikit-learn",
        "pandas",
        "python-multipart",
    ],
    python_requires=">=3.8",
) 