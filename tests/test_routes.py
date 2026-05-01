import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_health_endpoint_returns_200(client):
    response = client.get('/health')
    assert response.status_code == 200

def test_health_endpoint_returns_healthy_status(client):
    response = client.get('/health')
    data = response.get_json()
    assert data['status'] == 'healthy'

def test_metrics_endpoint_returns_200(client):
    response = client.get('/metrics')
    assert response.status_code == 200

def test_metrics_endpoint_has_cpu(client):
    response = client.get('/metrics')
    data = response.get_json()
    assert 'cpu_percent' in data

def test_metrics_endpoint_has_memory(client):
    response = client.get('/metrics')
    data = response.get_json()
    assert 'memory' in data

def test_metrics_endpoint_has_disk(client):
    response = client.get('/metrics')
    data = response.get_json()
    assert 'disk' in data

def test_dashboard_loads(client):
    response = client.get('/')
    assert response.status_code == 200