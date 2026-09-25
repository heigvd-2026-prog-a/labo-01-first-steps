"""Functional tests for the gcd program.

The program receives two integers on its command line and prints their
greatest common divisor on the standard output, alone on its line.
"""

import subprocess
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
EXEC = ROOT / "gcd"


def run(*args, timeout=5):
    """Run the program with the given command line arguments."""
    return subprocess.run(
        [str(EXEC), *map(str, args)],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        timeout=timeout,
    )


@pytest.fixture(scope="session", autouse=True)
def executable():
    if not EXEC.exists():
        pytest.fail(f"{EXEC.name} was not built, run `make` first")


# ---------- Nominal cases ----------
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (42, 36, 6),
        (12, 6, 6),
        (270, 192, 6),
        (1071, 462, 21),
        (42, 37, 1),
    ],
)
def test_prints_the_greatest_common_divisor(a, b, expected):
    assert run(a, b).stdout.strip() == str(expected)


def test_prints_only_the_result_on_its_own_line():
    assert run(42, 36).stdout == "6\n"


def test_exits_successfully():
    assert run(42, 36).returncode == 0


# ---------- Special cases ----------
@pytest.mark.parametrize("a, b", [(36, 42), (6, 12), (192, 270)])
def test_order_of_the_arguments_does_not_matter(a, b):
    assert run(a, b).stdout == run(b, a).stdout


def test_equal_numbers():
    assert run(17, 17).stdout.strip() == "17"


def test_one_divides_the_other():
    assert run(7, 91).stdout.strip() == "7"


def test_coprime_numbers():
    assert run(35, 64).stdout.strip() == "1"


@pytest.mark.parametrize("a, b", [(0, 5), (5, 0)])
def test_zero_and_a_number(a, b):
    assert run(a, b).stdout.strip() == "5"


def test_large_numbers():
    assert run(2147483646, 1073741823).stdout.strip() == "1073741823"


# ---------- Wrong usage ----------
@pytest.mark.parametrize("args", [(), (42,)], ids=["no-argument", "one-argument"])
def test_missing_arguments_are_reported_by_the_exit_status(args):
    process = run(*args)
    assert process.returncode > 0, "The program must fail, not crash"
