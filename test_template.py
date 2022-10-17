import pwnlib.tubes.remote as socket

def test_connection():
    r = socket.remote("127.0.0.1", 1337)
    output = r.recvall().decode()
    assert "Hello World" in output