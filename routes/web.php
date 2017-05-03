<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/memdashbaord/{mem_id}', 'RentRecordController@show');
Route::get('/memdashbaord/{mem_id}/create', 'RentRecordController@create');


Route::get('/admindashbaord', function () {
    return view('admin.adminDashboard');
});

Route::get('/login', function () {
    return view('auth.login');
});



