<?php
namespace App\Repository;

use Illuminate\Support\Facades\DB;


class ClassroomRepo
{
    public static function addClassroom($name,$size){
        DB::table('Classroom')
            ->insert(
                ['name' => $name, 'room_size' => $size]
            );
    }

    public static function deleteClassroom($classroomID){
        DB::table('Classroom')
            ->where('roomID', '=', $classroomID)
            ->delete();

    }

    public static function getClassroomByID($classroomID){
        $classroom = DB::table('Classroom')
            ->where('roomID', '=', $classroomID)
            ->get();

        return $classroom;
    }

    public static function updateClassroomByID($classroomID, $name, $size){
        DB::table('Classroom')
            ->where('roomID', '=', $classroomID)
            ->update(['name' => $name, 'room_size' => $size]);
    }

    public static function getAllClassroom(){
        $classroomList = DB::table('Classroom')
            ->get();

        return $classroomList;
    }
}