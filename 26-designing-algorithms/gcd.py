def gcd(m, n):
    def _gcd(larger, smaller):
        if smaller == 0:
            return larger
        else:
            return _gcd(smaller, (larger % smaller))
    return _gcd(max(m, n), min(m, n))
