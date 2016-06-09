hubble:
	docker build -t cs494/arcus-hubble -f Dockerfile .

collectd:
	docker build -t cs494/arcus-collectd -f Dockerfile.collectd .
