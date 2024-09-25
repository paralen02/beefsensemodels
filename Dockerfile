# Use TensorFlow Serving image
FROM tensorflow/serving

# Set the model path
ENV MODEL_NAME=saved3_model

# Copy the model from your local path to the Docker container
COPY saved3 /models/saved3_model

# Expose port for TensorFlow Serving
EXPOSE 8501

# Start TensorFlow Serving and load your model
ENTRYPOINT ["tensorflow_model_server", "--rest_api_port=8501", "--model_name=saved3_model", "--model_base_path=/models/saved3_model"]
