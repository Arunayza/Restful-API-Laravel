<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Movie;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MoviesController extends Controller
{
    public function showTable()
    {
        // Ambil semua data movie dari model
        $movies = Movie::all();

        // Kirim data ke view
        return view('users.table', compact('movies'));
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $movie = Movie::all();
        return response()->json([
            'status' => true,
            'message' => 'data berhasil ditemukan*',
            'data' => $movie
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'judul'=>'required',
            'sinopsis'=>'required',
            'poster'=>'required',
        ]);

        if($validator->fails()){
            return response()->json([
                'status'=>false,
                'message'=>'validasi error',
                'errors'=>$validator->errors()
            ], 422);
        }

        $movie = Movie::create($request->all());
        return response()->json([
            'status' => true,
            'message' => 'data berhasil dimasukkan',
            'data' => $movie
        ],201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $movie = Movie::findOrFail($id);
        return response()->json([
            'status' => true,
            'message' => 'data berhasil ditemukan',
            'data' => $movie
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $validator = Validator::make($request->all(), [
            'judul' => 'required',
            'sinopsis' => 'required',
            'poster' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'validasi error',
                'errors' => $validator->errors()
            ], 422);
        }

        $movie = Movie::findOrFail($id);
        $movie->update($request->all());
        return response()->json([
            'status' => true,
            'message' => 'data berhasil di update',
            'data' => $movie
        ], 200);
    }

    /*
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $movie = Movie::findOrFail($id);
        $movie->delete();
        return response()->json([
            'status' => true,
            'message' => 'data berhasil di hapus',
            'data' => $movie
        ], 204);
    }
}
