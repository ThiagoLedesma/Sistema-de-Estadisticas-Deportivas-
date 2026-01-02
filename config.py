from collections.abc import Callable
from typing import Any, TypeVar, overload

from psycopg2 import errors as errors, extensions as extensions
from psycopg2._psycopg import (
    BINARY as BINARY,
    DATETIME as DATETIME,
    NUMBER as NUMBER,
    ROWID as ROWID,
    STRING as STRING,
    Binary as Binary,
    DatabaseError as DatabaseError,
    DataError as DataError,
    Date as Date,
    DateFromTicks as DateFromTicks,
    Error as Error,
    IntegrityError as IntegrityError,
    InterfaceError as InterfaceError,
    InternalError as InternalError,
    NotSupportedError as NotSupportedError,
    OperationalError as OperationalError,
    ProgrammingError as ProgrammingError,
    Time as Time,
    TimeFromTicks as TimeFromTicks,
    Timestamp as Timestamp,
    TimestampFromTicks as TimestampFromTicks,
    Warning as Warning,
    __libpq_version__ as __libpq_version__,
    apilevel as apilevel,
    connection,
    cursor,
    paramstyle as paramstyle,
    threadsafety as threadsafety,
)
