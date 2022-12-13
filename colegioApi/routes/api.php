<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{AlumnosController,EducadoresController,EventosController,HistorialController,NivelController};
use App\Models\Alumnos;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::get('/educadores/niv/{nivel}', [EducadoresController::class, 'getXNivel']);
Route::get('/alumnos/niv/{nivel}', [AlumnosController::class, 'getXNivel']);
Route::get('/alumnos/niv/cantidad/{nivel}', [AlumnosController::class, 'getCantAlumnos']);
Route::get('/historial/rut/{rut_alumno}', [HistorialController::class, 'getXRut']);
Route::apiResource('/alumnos',AlumnosController::class);
Route::apiResource('/educadores',EducadoresController::class);
Route::apiResource('/eventos',EventosController::class);
Route::apiResource('/historial',HistorialController::class);
Route::apiResource('/nivel',NivelController::class);

