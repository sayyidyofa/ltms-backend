-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'TEACHER', 'STUDENT', 'TAHFIZH_HEAD', 'KATIB', 'PARENT');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('M', 'F');

-- CreateEnum
CREATE TYPE "SessionType" AS ENUM ('Murojaah', 'Setoran');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Teacher" (
    "id" SERIAL NOT NULL,
    "loginName" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "birthPlace" TEXT NOT NULL,
    "birthDate" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TahfizhGroup" (
    "id" SERIAL NOT NULL,
    "teacherId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Student" (
    "id" SERIAL NOT NULL,
    "nit" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "birthPlace" TEXT NOT NULL,
    "birthDate" TIMESTAMP(3) NOT NULL,
    "tahunMasuk" INTEGER NOT NULL,
    "tahunLulus" INTEGER NOT NULL,
    "tahfizhGroupId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" SERIAL NOT NULL,
    "waktuMulai" TIMESTAMP(3) NOT NULL,
    "waktuSelesai" TIMESTAMP(3) NOT NULL,
    "juz" INTEGER NOT NULL,
    "halaman" INTEGER NOT NULL,
    "awalSetoran" TEXT NOT NULL,
    "akhirSetoran" TEXT NOT NULL,
    "tajwid" INTEGER NOT NULL,
    "kelancaran" INTEGER NOT NULL,
    "makhrojSifat" INTEGER NOT NULL,
    "teacherId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,
    "type" "SessionType" NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Percepatan" (
    "id" SERIAL NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "sessionId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Alquran" (
    "id" SERIAL NOT NULL,
    "juz" INTEGER NOT NULL,
    "halaman" INTEGER NOT NULL,
    "surah" TEXT NOT NULL,
    "awalAyatHal" TEXT NOT NULL,
    "akhirAyatHal" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User.username_unique" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Teacher.loginName_unique" ON "Teacher"("loginName");

-- CreateIndex
CREATE UNIQUE INDEX "Teacher.email_unique" ON "Teacher"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Teacher_userId_unique" ON "Teacher"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Student.nit_unique" ON "Student"("nit");

-- CreateIndex
CREATE UNIQUE INDEX "Student_userId_unique" ON "Student"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Percepatan_sessionId_unique" ON "Percepatan"("sessionId");

-- AddForeignKey
ALTER TABLE "Teacher" ADD FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TahfizhGroup" ADD FOREIGN KEY ("teacherId") REFERENCES "Teacher"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Student" ADD FOREIGN KEY ("tahfizhGroupId") REFERENCES "TahfizhGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Student" ADD FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD FOREIGN KEY ("teacherId") REFERENCES "Teacher"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD FOREIGN KEY ("studentId") REFERENCES "Student"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Percepatan" ADD FOREIGN KEY ("sessionId") REFERENCES "Session"("id") ON DELETE CASCADE ON UPDATE CASCADE;
