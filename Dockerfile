FROM alpine:3.14

# Install TensorFlowServing
RUN apk add --no-cache curl gnupg && \
    mkdir -p /etc/apt/sources.list.d && \
    echo "deb http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | tee /etc/apt/sources.list.d/tensorflow-serving.list && \
    curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | apt-key add - && \
    apk update && \
    apk add --no-cache tensorflow-model-server

# Copy the model to serve
COPY saved3 /models/saved3_model

# Run the tensorflow_model_server with the right parameters
ENTRYPOINT ["sh", "-c", "tensorflow_model_server --port=8500 --rest_api_port=$PORT --model_base_path=/models/saved3_model --model_name=saved3_model"]
