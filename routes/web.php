<?php

use App\Http\Controllers\Api\MoviesController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/users-table',[MoviesController::class,'showTable']);