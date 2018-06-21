apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ${app_name}
  namespace: ${namespace}
spec:
  replicas: ${replicas}
  template:
    metadata:
      labels:
        app: ${app_name}
    spec:
      containers:
      - name: ${app_name}
        image: node-app:latest
        imagePullPolicy: Never
        ports:
        - containerPort: 3000
      volumes:
      - name: config-volume
        configMap:
          name: ${configmap_name}

