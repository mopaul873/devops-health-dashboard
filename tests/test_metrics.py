from app.metrics import get_metrics

def test_get_metrics_returns_dict():
    result = get_metrics()
    assert isinstance(result, dict)

def test_get_metrics_has_cpu():
    result = get_metrics()
    assert 'cpu_percent' in result

def test_get_metrics_cpu_is_valid():
    result = get_metrics()
    assert 0 <= result['cpu_percent'] <= 100

def test_get_metrics_has_memory():
    result = get_metrics()
    assert 'memory' in result

def test_get_metrics_memory_has_keys():
    result = get_metrics()
    assert 'total_gb' in result['memory']
    assert 'used_gb' in result['memory']
    assert 'percent' in result['memory']

def test_get_metrics_memory_percent_is_valid():
    result = get_metrics()
    assert 0 <= result['memory']['percent'] <= 100

def test_get_metrics_has_disk():
    result = get_metrics()
    assert 'disk' in result

def test_get_metrics_disk_has_keys():
    result = get_metrics()
    assert 'total_gb' in result['disk']
    assert 'used_gb' in result['disk']
    assert 'percent' in result['disk']

def test_get_metrics_disk_percent_is_valid():
    result = get_metrics()
    assert 0 <= result['disk']['percent'] <= 100