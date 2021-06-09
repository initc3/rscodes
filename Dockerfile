FROM python:3.7 as base

# NTL
# ?: Would installing libntl-dev be sufficient?
#ENV LIBRARY_PATH /usr/local/lib
#ENV LIBRARY_INCLUDE_PATH /usr/local/include
#COPY --from=initc3/ntl:11.4.1-buster $LIBRARY_INCLUDE_PATH/NTL $LIBRARY_INCLUDE_PATH/NTL
#COPY --from=initc3/ntl:11.4.1-buster $LIBRARY_PATH/libntl.a $LIBRARY_PATH/libntl.a

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgmp-dev \
        libmpc-dev \
        libmpfr-dev \
        libntl-dev \
	&& rm -rf /var/lib/apt/lists/*


WORKDIR /usr/src/rscodes
COPY Makefile pyproject.toml setup.py setup.cfg ./
COPY src src


FROM base as dev

RUN apt-get update && apt-get install -y --no-install-recommends \
                vim \
        && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

#RUN pip install cython
RUN pip install git+https://github.com/initc3/pyntl.git

RUN pip install --editable .['dev,test']

COPY tests tests
COPY .flake8 pytest.ini ./

FROM base as dist

RUN pip install build
RUN make clean && python -m build

FROM scratch AS export-stage
COPY --from=dist /usr/src/rscodes/dist /
