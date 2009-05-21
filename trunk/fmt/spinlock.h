1400 #ifndef XV6_SPINLOCK_H_
1401 #define XV6_SPINLOCK_H_
1402 // Mutual exclusion lock.
1403 struct spinlock {
1404   uint locked;   // Is the lock held?
1405 
1406   // For debugging:
1407   char *name;    // Name of lock.
1408   int  cpu;      // The number of the cpu holding the lock.
1409   uint pcs[10];  // The call stack (an array of program counters)
1410                  // that locked the lock.
1411 };
1412 #endif // XV6_SPINLOCK_H_
1413 
1414 
1415 
1416 
1417 
1418 
1419 
1420 
1421 
1422 
1423 
1424 
1425 
1426 
1427 
1428 
1429 
1430 
1431 
1432 
1433 
1434 
1435 
1436 
1437 
1438 
1439 
1440 
1441 
1442 
1443 
1444 
1445 
1446 
1447 
1448 
1449 
1450 // Blank page.
1451 
1452 
1453 
1454 
1455 
1456 
1457 
1458 
1459 
1460 
1461 
1462 
1463 
1464 
1465 
1466 
1467 
1468 
1469 
1470 
1471 
1472 
1473 
1474 
1475 
1476 
1477 
1478 
1479 
1480 
1481 
1482 
1483 
1484 
1485 
1486 
1487 
1488 
1489 
1490 
1491 
1492 
1493 
1494 
1495 
1496 
1497 
1498 
1499 
