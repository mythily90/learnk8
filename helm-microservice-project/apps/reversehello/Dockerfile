FROM python:3-alpine

WORKDIR /app

COPY src/requirement.txt ./

RUN pip install -r requirement.txt

COPY src /app/

EXPOSE 5002

ENTRYPOINT [ "python" ]


CMD [ "reverseapi.py" ]