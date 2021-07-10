/*
  Warnings:

  - You are about to drop the column `studentNit` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `teacherCode` on the `Session` table. All the data in the column will be lost.
  - The primary key for the `Student` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `teacherCode` on the `TahfizhGroup` table. All the data in the column will be lost.
  - The primary key for the `Teacher` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `code` on the `Teacher` table. All the data in the column will be lost.
  - You are about to drop the column `code` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[nit]` on the table `Student` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[loginName]` on the table `Teacher` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[username]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `studentId` to the `Session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `teacherId` to the `Session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `teacherId` to the `TahfizhGroup` table without a default value. This is not possible if the table is not empty.
  - Added the required column `loginName` to the `Teacher` table without a default value. This is not possible if the table is not empty.
  - Added the required column `username` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Session" DROP CONSTRAINT "Session_studentNit_fkey";

-- DropForeignKey
ALTER TABLE "Session" DROP CONSTRAINT "Session_teacherCode_fkey";

-- DropForeignKey
ALTER TABLE "TahfizhGroup" DROP CONSTRAINT "TahfizhGroup_teacherCode_fkey";

-- DropIndex
DROP INDEX "User.code_unique";

-- AlterTable
ALTER TABLE "Session" DROP COLUMN "studentNit",
DROP COLUMN "teacherCode",
ADD COLUMN     "studentId" INTEGER NOT NULL,
ADD COLUMN     "teacherId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Student" DROP CONSTRAINT "Student_pkey",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "TahfizhGroup" DROP COLUMN "teacherCode",
ADD COLUMN     "teacherId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Teacher" DROP CONSTRAINT "Teacher_pkey",
DROP COLUMN "code",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "loginName" TEXT NOT NULL,
ADD PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "User" DROP COLUMN "code",
ADD COLUMN     "username" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Student.nit_unique" ON "Student"("nit");

-- CreateIndex
CREATE UNIQUE INDEX "Teacher.loginName_unique" ON "Teacher"("loginName");

-- CreateIndex
CREATE UNIQUE INDEX "User.username_unique" ON "User"("username");

-- AddForeignKey
ALTER TABLE "TahfizhGroup" ADD FOREIGN KEY ("teacherId") REFERENCES "Teacher"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD FOREIGN KEY ("teacherId") REFERENCES "Teacher"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD FOREIGN KEY ("studentId") REFERENCES "Student"("id") ON DELETE CASCADE ON UPDATE CASCADE;
