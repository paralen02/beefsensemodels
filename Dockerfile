FROM ubuntu:xenial

# Install TensorFlowServing
RUN apt update && \
    apt-get install -y curl && \
    echo "deb http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | tee /etc/apt/sources.list.d/tensorflow-serving.list && \
    curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | apt-key add - && \
    apt update && \
    apt-get install tensorflow-model-server

# Copy the model to serve
COPY saved3 /models/saved3_model

# Run the tensorflow_model_server with the right parameters
CMD tensorflow_model_server --port=8500 --rest_api_port=${PORT} --model_base_path=/models/saved3_model --model_name=saved3_model
