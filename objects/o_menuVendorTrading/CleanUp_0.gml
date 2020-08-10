/// @description Control

controlCleanup();

// cleanup item array and shunt it back to the respective inventories
itemArrayFree(m_itemarray_rx);
itemArrayFree(m_itemarray_tx);