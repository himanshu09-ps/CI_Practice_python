from app import app

def test_home():
    client = app.test_client()
    response = client.get("/")
    assert response.data == b"Hello CI"

def test_health():
    client = app.test_client()
    response = client.get("/health")
    assert response.data == b"OK"
