FROM rocm/dev-ubuntu-22.04:latest

RUN apt update -y && \
apt install -y libglib2.0-0 libsm6 libxrender1 libxext6 rocsolver hipsolver rccl rocm-libs && \
apt-get autoclean && \
rm -rf /var/lib/apt/lists/* && \
ldconfig && \
pip3 install jupyterlab opencv-python matplotlib numba pillow && \
pip3 install jupyter_contrib_nbextensions jupyter_nbextensions_configurator && \
pip3 install --upgrade notebook==6.4.12 traitlets==5.9.0 && \
jupyter contrib nbextension install --user && \
jupyter nbextensions_configurator enable --user && \
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.1 && \
python3 -m pip install https://github.com/ROCm/jax/releases/download/rocm-jaxlib-v0.4.30/jaxlib-0.4.30+rocm611-cp310-cp310-manylinux2014_x86_64.whl && \
python3 -m pip install https://github.com/ROCm/jax/archive/refs/tags/rocm-jaxlib-v0.4.30.tar.gz && \
pip3 cache purge

ENV LD_LIBRARY_PATH=/opt/rocm-6.2.1/lib

WORKDIR /workspace

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
