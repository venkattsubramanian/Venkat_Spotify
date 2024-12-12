//
//  HomeViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 11/12/24.
//

import Foundation
import SQLite3

class DBHandler {
    
    private var db: OpaquePointer?
    private let dbName = "TracksDB.sqlite"
    private let tableName = "Tracks"
    private let playlistsTable = "Playlists"

    
    init() {
        openDatabase()
        printTableSchema()
        addMissingColumn()
        createTable()
        createPlaylistsTable()
    }
    
    private func openDatabase() {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Unable to find documents directory.")
            return
        }
        
        let dbPath = documentsDir.appendingPathComponent(dbName).path
        
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("Failed to open database.")
        } else {
            print("Database opened successfully at \(dbPath)")
        }
    }
    
    private func createTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS \(tableName) (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            trackName TEXT,
            artistName TEXT,
            trackURL TEXT
        );
        """
        
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Table \(tableName) created successfully.")
            } else {
                print("Failed to create table.")
            }
        } else {
            print("Failed to prepare create table statement.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    private func printTableSchema() {
        let query = "PRAGMA table_info(\(tableName));"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            print("Table schema:")
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let columnName = String(cString: sqlite3_column_text(queryStatement, 1))
                let columnType = String(cString: sqlite3_column_text(queryStatement, 2))
                print("Column: \(columnName), Type: \(columnType)")
            }
        } else {
            print("Failed to retrieve table schema.")
        }
        
        sqlite3_finalize(queryStatement)
    }
    
    private func addMissingColumn() {
        let checkColumnQuery = "PRAGMA table_info(\(tableName));"
        var queryStatement: OpaquePointer?
        var hasColumn = false
        
        if sqlite3_prepare_v2(db, checkColumnQuery, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let columnName = String(cString: sqlite3_column_text(queryStatement, 1))
                if columnName == "trackURL" {
                    hasColumn = true
                    break
                }
            }
        } else {
            print("Failed to check table columns.")
        }
        
        sqlite3_finalize(queryStatement)
        
        if !hasColumn {
            let addColumnQuery = "ALTER TABLE \(tableName) ADD COLUMN trackURL TEXT;"
            var addColumnStatement: OpaquePointer?
            if sqlite3_prepare_v2(db, addColumnQuery, -1, &addColumnStatement, nil) == SQLITE_OK {
                if sqlite3_step(addColumnStatement) == SQLITE_DONE {
                    print("Column 'trackURL' added successfully.")
                } else {
                    print("Failed to add 'trackURL' column.")
                }
            } else {
                print("Failed to prepare add column statement.")
            }
            sqlite3_finalize(addColumnStatement)
        }
    }
    
    func insertTrack(trackName: String, artistName: String, trackURL: String) {
        let insertQuery = "INSERT INTO \(tableName) (trackName, artistName, trackURL) VALUES (?, ?, ?);"
        
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, trackName, -1, nil)
            sqlite3_bind_text(insertStatement, 2, artistName, -1, nil)
            sqlite3_bind_text(insertStatement, 3, trackURL, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Track inserted successfully: \(trackName)")
            } else {
                print("Failed to insert track.")
            }
        } else {
            print("Failed to prepare insert statement.")
        }
        
        sqlite3_finalize(insertStatement)
    }
    
    
    func fetchTracks() -> [(trackName: String, artistName: String, trackURL: String)] {
        let fetchQuery = "SELECT * FROM \(tableName);"
        var fetchStatement: OpaquePointer?
        var tracks: [(trackName: String, artistName: String, trackURL: String)] = []
        
        if sqlite3_prepare_v2(db, fetchQuery, -1, &fetchStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                // Safely unwrap the columns
                let trackName = sqlite3_column_text(fetchStatement, 1) != nil ? String(cString: sqlite3_column_text(fetchStatement, 1)) : ""
                let artistName = sqlite3_column_text(fetchStatement, 2) != nil ? String(cString: sqlite3_column_text(fetchStatement, 2)) : ""
                let trackURL = sqlite3_column_text(fetchStatement, 3) != nil ? String(cString: sqlite3_column_text(fetchStatement, 3)) : ""
                
                tracks.append((trackName: trackName, artistName: artistName, trackURL: trackURL))
            }
        } else {
            print("Failed to prepare fetch statement.")
        }
        
        sqlite3_finalize(fetchStatement)
        return tracks
    }
    
    func createPlaylistsTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS \(playlistsTable) (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            playlistName TEXT NOT NULL
        );
        """
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Table \(tableName) created successfully.")
            } else {
                print("Failed to create table.")
            }
        } else {
            print("Failed to prepare create table statement.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    func insertPlaylist(name: String) {
        let insertQuery = "INSERT INTO \(playlistsTable) (playlistName) VALUES (?);"
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, name, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Playlist inserted successfully: \(name)")
            } else {
                print("Failed to insert playlist.")
            }
        } else {
            print("Failed to prepare insert statement.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func fetchPlaylists() -> [String] {
        let fetchQuery = "SELECT playlistName FROM \(playlistsTable);"
        var fetchStatement: OpaquePointer?
        var playlists: [String] = []
        
        if sqlite3_prepare_v2(db, fetchQuery, -1, &fetchStatement, nil) == SQLITE_OK {
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                if let playlistName = sqlite3_column_text(fetchStatement, 0) {
                    playlists.append(String(cString: playlistName))
                }
            }
        } else {
            print("Failed to prepare fetch statement.")
        }
        
        sqlite3_finalize(fetchStatement)
        return playlists
    }
}



