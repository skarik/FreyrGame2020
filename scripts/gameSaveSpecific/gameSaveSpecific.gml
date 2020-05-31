/// @function gameSaveSpecific(from)
/// @param from {kSaveFrom}

#macro kSaveFromBook 0
#macro kSaveFromCheckpointMinor 1
#macro kSaveFromCheckpointMajor 2

var save_from = argument0;

// TODO

gameSave();

// if from book, do not mark as things need to respawn
